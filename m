Return-Path: <stable+bounces-230030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FEMDD/OwWnhWwQAu9opvQ
	(envelope-from <stable+bounces-230030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:35:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2D2FF023
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D3723035D51
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996A372B53;
	Mon, 23 Mar 2026 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="EmGNdrdU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E75358369;
	Mon, 23 Mar 2026 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308878; cv=fail; b=JLWGB08ODvUGTWO4xNsHkmKuBH7y4C4DK5G2giJv8gg5Qe8OgVr4PVbS4vjFtRwKRZIzaedlCq2Dalr4B0S1poWwejxR6ytoUCcW8UUCKdcmsssVZZZMVvOV8Q5ZdXe+mFNYyUcEJ/NqDNcBadKlJdlD4uQAfxIjtnpTxgiWQHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308878; c=relaxed/simple;
	bh=YsmXUVF2EyI9cQHxC66p5j52Df3L0eIBaJkjDrPcMbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2KvBkulVt/WHFDr5sbGDbmV/VvD1DaFrvSRP5gb3UbNKxmjgTCFjFm2eGLNr+KmbOV9glS1CZPjE4nzjkWVVAPXCyddt6RBJd8D339pBjjYyn/1CXPCY1xpxmYh7snmn8HqR747FoNdc9PU29OjBnD+Hu1y+4aM5lbsIGxJaKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=EmGNdrdU; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NKWIDD3517312;
	Mon, 23 Mar 2026 23:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=0D
	dfeUnIkpITDQRbqTsqdAKlbGqlY2e2iaLUDZFm4UE=; b=EmGNdrdUB1O93HrU09
	eHlleDuHZdncml2t4HuF1OaE1yItzWbuHEhDvCA9JpLNiKzFNzqjXEwboAtvl4YY
	/VJEXNRA+DHZ7hp8ubupFMdD/mAgd1foQdstnNcPBWQSQhow2ejIjF5hE9/pGhLk
	ZbvVFt9vCRa3vkjDhXspkC3ibI9Nduch/tTIubWlkoBqb75LE96KxwrEf1JM+obu
	YRXIrMzislTlL7rwGUI8aa/TvFH6aHiMpQ4bjzJqFQQ0yfIWDrk0RzIdwxBc1m5j
	5uUgpLRPpzQxG1t24LNgkxgF/Q/cmhpwsLlwzkcsskozGxRzsQaPaav8eUDfNf4c
	OqYQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d3aaxk776-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 23:34:21 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 3037ED1E2;
	Mon, 23 Mar 2026 23:34:21 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:34:15 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 11:34:15 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:34:15 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz/yynwkhmejwO4vei3rARG8bJLE10XH0MA+eZo1/Z94sPgZk8mJiK8kKpgykFvgkyaZN2WIGo2Z8VqOX3cDANDS9/T4E6tGMKHJRiaWuZqjTRfY2R9ITC80m0yk29Rk5S0PHOsLnPIkVLaRIXrwZgS+GQs7dU45HaEM3gKsLM+DIV92XrBX4LNayDiaSH8MiYqEch/AsOS871gSAw74aGxTDFisO/K29591YP9cTuXeNUV23Vnbkwo6KG3iE5IAPtp7E/o3k7Qz5mjNbvnSMs8KwvnC76Oy+IX4qVCVjqSuXSZwa+RFzZEOXjtbaC4LlhB3W1snvsbZR2kEvkojLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DdfeUnIkpITDQRbqTsqdAKlbGqlY2e2iaLUDZFm4UE=;
 b=ixO6eaee73pDEnoz+Mv4dWPHFW0b5fgG1Ve7xBWS+gDuXpVuqGiDn5DDxyUeBNnpIblNrgL6N0dfhotUHStQdEMl4NB3E9V3qn8eIGFGH+ssNznjlYqasgfAh5LAgtLWu+8JCfKMGnwtj+ezIiGi+aHgDHa2MO2/dFKjEjRDC90IAuHtAH1CzYjP9WGsW71AVLp0qrpE6EDksh43dHpuXhqZOKI0wIyu+f7MgXe+jePHTTDJWdQU1zudS/TDhHdOZxx9M/VzKkzZ8phc3S0C3KXCMMZn9HZUa3ssMvODUwNUqcBg6C8Nnd3DKj7sptY7bNJxNyTjUdw4y9ejdNe3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CH3PR84MB3989.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 23:34:14 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 23:34:14 +0000
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
Subject: [PATCH v2 4/5] hwmon: (pmbus/mp29502) Replace raw I2C calls with
 PMBus core API
Thread-Topic: [PATCH v2 4/5] hwmon: (pmbus/mp29502) Replace raw I2C calls with
 PMBus core API
Thread-Index: AQHcux2OfW9YJVHOYE2qNhuN/U90VQ==
Date: Mon, 23 Mar 2026 23:34:14 +0000
Message-ID: <20260323233244.201294-5-sanman.pradhan@hpe.com>
References: <20260323233244.201294-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323233244.201294-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CH3PR84MB3989:EE_
x-ms-office365-filtering-correlation-id: 1b6594d0-d700-45fc-e3f0-08de8934b17c
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: sHoxk060odwpj47JD9+rf1ipQkjf74Ix32gHOZgTEtjhq005HYo/eGgwIf10bo2bM74g7JJVdVABneKSy9f519K3A+vkGUyZKnAt7LLHpfWyuXwJnon92fovzucJP4VDt3z34DQ9oQoy32iWPjUEodVsuVMgUMzVNu5G1kPqEiFx82jP6iL9GxX3arYqTsQQ+f8kwfndHGALHWBQVB0wwLjvE8fd1wVihTA3U6QLPt2UA3VG3YGsYcPHYfoLrJ4Bimhyd+K8EQ2uB2lnIqAWf+VunhZJbn/c7vLBkvdDVvgLLcRSQ8wUYmTaNjbiJ+/4MjFF13HS0ZL91r1qnuxJONz+1DmMa24RB6eXvTZNP21AEEjsncrdD2RVsrX6k9ZAHGPAL9yLfvTlDTEMgUZ/AclJvFgRW8OSsydiii1K5Bg9m4orGLyYkU60JYDiRAVmeKtS6zK0Gd4uONT+jpUfBA1BFC8OOw0F7qErhIWTtMO4jOIhy723VC91OYil/Z6OYh495llgw5h/+hGl8aJA0wyFXfvHONfm9uVfeu0Gu35zuzdk7gbqwx5fDIpc5/jQCTVSrLdSl4DieSNLDJy09myxlmkcNustEQuRsoDdfH2N1MuIs5AqRAkHQD43uhagajmXdthEIXebpa/NNBzRotJsiOm4k4p2hHX0yvy6UZTMX7jOFgInd/8RZK4Eha1MPsGHzETUDOU7e1nrkh7rI9/LZFP7kflRbg7c3/iAfEfYQT9ciM/Tzuidmy17K7LmMYT1/aJEuUqnIMknKSpdkv0APM9gAhkqGmpw0s8FGPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SrOXL2HBzNaasc8WKgfmjWAJ0A/uwNYIYbbwz0zpWaXkga0aoIKHAOPcRa?=
 =?iso-8859-1?Q?B6n0Ei6H4bGobJQ4jsI0+76B+iwRN8g+qGzG9xcC5hIASq7lKlPR0WnNUf?=
 =?iso-8859-1?Q?eV80clPgyw+Bq/R2a8AEU5p2aYQ18kdfF/q3kZV8Vh6KBtGcU6YsmJcTpJ?=
 =?iso-8859-1?Q?8yHQ0xfDENWxfg10H0SLf6215v8DrdKV27LG3Te8M3eZ1L9ci1PVnmmCF4?=
 =?iso-8859-1?Q?SeKR/FUmuhwkr19BPDtUaouJ77wOa+HcE9G2QBuCxiOZI26GJsv+R7FOAL?=
 =?iso-8859-1?Q?3fnTFhdL72IBRp5b+Y5u7K4l5uy8fc80HUCy0HCzrPm19vwpIARyRypBLO?=
 =?iso-8859-1?Q?bCBYiz3wNuoG1jqaA+bLr24wJeY67Iay8vdStxVKhjvaCc9lB8gv5Mwy7e?=
 =?iso-8859-1?Q?Xd6wzOZGZOwZQ4vEjzFPLIsA0XwZPCnMbwynDh27fPEkh9WBK/i8Poc65c?=
 =?iso-8859-1?Q?1hKi5HysG5QKK8Veh65DsySiQZzXIRWXbRuILx3syXiPAIF5FpIQFbql9Y?=
 =?iso-8859-1?Q?sIYVOlPbIpXfA5GAEdf2qIeTCOyLOON1/3RydFpvGSfqEynth1wjVyubEt?=
 =?iso-8859-1?Q?K07rNflXnHDwFNJHq+Z+zawRV+0zVHEKmWrsZv3c8iDeJzhdyEEc9TLfgY?=
 =?iso-8859-1?Q?T3+YG3OhkRQqR9nbqDi/izE0JsMuj0tlEtLQE0oWoF0pS3GyJ83FD3OKJy?=
 =?iso-8859-1?Q?yOWl7ucadX7OwHOGuNnBx6OMpvNcgt4Tiv+kKLPw80G6xOknV5atQVNb7k?=
 =?iso-8859-1?Q?gzBqoiE72OOWY1zpznSXWYWeeJTzS4WIRHWpMPzHUdgDjcNc9jKuw0uvnl?=
 =?iso-8859-1?Q?/fjMrKNx1HSQPMlJ/M9dFdxzJrlKvNZvVXzGDhT8CDStfMon3atflRQeka?=
 =?iso-8859-1?Q?6Tf+guxCKJvSDfyNvABlvCR3uzjRwOZXrw16ZEQI388w8D5tTTFbXXbgnW?=
 =?iso-8859-1?Q?PA+eQXiJCK4fDyplFQTFN0QS1wKTcYS23mD62sg7E6HTx5v8Z0Qti6yCjK?=
 =?iso-8859-1?Q?vHrWY1xA89fmnMl3UaBymhlWnRUyAqVAu+/RqXrsJ/6Dkp6DTHtFLEWgX1?=
 =?iso-8859-1?Q?3W4mZL7hHL5bE6TjxTtG4Qm5dvAelrc1RQrb6dyyocjMoigadi40BxVucW?=
 =?iso-8859-1?Q?IHVXnWkOU4u29murs6aejHItnxUcJ4AIuV0QS8Egil3psQlSJ9u9LbmseU?=
 =?iso-8859-1?Q?0ZeFEwpMIurE3V6sT/ka7vthISNJZgk7R1UFh1ja4UhGOZCGL71F5eSbvj?=
 =?iso-8859-1?Q?TDTeznxcZuSlyuvGfybIuPuFOSE8YSWYkyGn1mztb8u5xFPYhb0g+QiggC?=
 =?iso-8859-1?Q?3hGGMF3/PEXFOs37Efstf+WmMu9Y+0IaZgCvHeNAwe1YZJ2gnC3RCI7WP9?=
 =?iso-8859-1?Q?TVmTeoi+RMJaiMHkW2XuPnnWSD9+viywQpMkeSbQo63N95PBc8KmpeVRh8?=
 =?iso-8859-1?Q?RSAY0kyeV1D9n08IjrmKIXyFp+kSeNu4O0HkO2qfAiVyv2/yC3y2LusE7D?=
 =?iso-8859-1?Q?D58bDaYUY1+sLHnewuPq6xb0fgajHPu8oJBzN+RJGoNJa/hdjWJaN1XtC/?=
 =?iso-8859-1?Q?GHL2Xqofg9gsYi4fruyp2MpKw+QIsPm6vA8NS/6e00y3IGNinWie4BgfY1?=
 =?iso-8859-1?Q?L9gxp/UQv3rwiypm4bZHBeJHFKI/zwmrtwtnRKvYSGM8oDoC5879+1Doim?=
 =?iso-8859-1?Q?/riGsc62HO7hiEjQ+0d5zmlh7s/sHKixqYN7u2Weti3LBQZDqOCADcyUIA?=
 =?iso-8859-1?Q?4Nsgp+RdQ2dsXmam2HNEujCwTM5iSjTZao8Fi+NeME5ekpw1h5bndvIvZU?=
 =?iso-8859-1?Q?2vD4wyInYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vewYyfR0kprEPJkCtuCg/Li3QDY9zxUC3lPl9oJeIV+AM1AVNNlSg13+5eSPp1ULMUCbhwxg3eoRPAwcT6Ldzt7YmfVbzDtczfsZOxQGXe+29Q6T7eHSqlmMN81zJuBIXUni2MpCu9KRCZSFKUbO+GBoo9ewL2bvfVsv5ONyRwuvK0FWGEcee3wr9++CigBOO+xiIwmAKX6Zw7c+xAMb2JuePIBDmb4ophY+Q0xG6GgdMN7C+dE3BN50W+OVD25SbZp+YfdFB/BcQ7X/+eSIust4cF8Yyaw/DvEH7B9jdmZ5HxhHuV4pA2ZeuOrBsrzmo6JnAVHmyxM8OiQUeP8NOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6594d0-d700-45fc-e3f0-08de8934b17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 23:34:14.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmBX9qIPLPjJ9QjUzrKB6ZqgjNcIR87doqYeUz9NiBXwAv5A3JrlKVu8vlkbgt095V8DuRgmaLtL1wmH0asXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3989
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Trdam-NGsZJA9Mnfbd_NE5TJ2JZsU8XW
X-Proofpoint-ORIG-GUID: Trdam-NGsZJA9Mnfbd_NE5TJ2JZsU8XW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MyBTYWx0ZWRfXywvRnh4oM0YY
 o4WbZfIocT6TZWvfh+K4/9NkFUl5fWrssHySsPz7jq4JNzkf7mTRb+u1xX56nGHIvNWi+3nb6P0
 pOoIeYr1U5rlAer1OU944I+9uuwZd2g4tM3WpFFvMg1/+dQW2LZhkTVH/Q0GziXvYZcgBjCae/L
 dnsE6Nzr9RjZTs6fbLDbzTuQJeJsyph/lEnaf9621ME4jW45/oHzUk6NG/Q2nglmPxL1A3NRKBD
 c4RuSChm8zJcyDDikfDEnmqTPan1tigkSwK4G7aA2a8Ckr9bw9p+Lgr1fpe1XmeuRejygMhsqEb
 Uq4EWc8ce92NA+oHtWiCqIero6pPEdChR6fwOEATTbSjtiNU0G5nyDx7z6TG+22CoozzNnoDXLx
 zbJ2NrT9XhsPNZmpSeehjhpif/6Pr1NPE4FIUU+XYKW3NdZ4fVIjI7nQawtq04IkrOAJyJh4YMe
 gER9IYUynIVPMH+3DcA==
X-Authority-Analysis: v=2.4 cv=bqRBxUai c=1 sm=1 tr=0 ts=69c1cdfd cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=0ch_ZG7wXMlDUe8ALHQA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230173
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230030-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: C2A2D2FF023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The mp29502 read_byte_data, read_vout_ov_limit, write_vout_ov_limit,=0A=
and write_word_data callbacks use raw i2c_smbus_write_byte_data() to=0A=
set PMBUS_PAGE and raw i2c_smbus_read/write_word_data() for register=0A=
access. These raw page writes desynchronize the PMBus core's internal=0A=
page cache: after a raw write to PMBUS_PAGE, the core still believes=0A=
the previous page is selected and may skip the page-select on the=0A=
next pmbus_read_word_data() call, reading from the wrong page. As a=0A=
secondary benefit, switching to the core helpers also routes all=0A=
post-probe accesses through the update_lock mutex, closing a potential=0A=
race with concurrent sysfs reads.=0A=
=0A=
Replace the raw I2C calls in read_vout_ov_limit and write_vout_ov_limit=0A=
with pmbus_read_word_data(client, 1, 0xff, reg) and=0A=
pmbus_write_word_data(client, 1, reg, word), which handle page=0A=
selection, page cache coherency, and locking internally. Page 1 is=0A=
selected explicitly as the OV limit registers reside on page 1 per the=0A=
datasheet; the phase argument 0xff indicates phase is not applicable.=0A=
Remove the manual PMBUS_PAGE writes from read_byte_data and=0A=
write_word_data, and simplify read_byte_data to use direct returns.=0A=
=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
- No changes to this patch in this version.=0A=
---=0A=
 drivers/hwmon/pmbus/mp29502.c | 68 +++++++++--------------------------=0A=
 1 file changed, 17 insertions(+), 51 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index 1457809aa7e4..aef9d957bdf1 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -210,31 +210,18 @@ mp29502_identify_iout_scale(struct i2c_client *client=
, struct pmbus_driver_info=0A=
 static int mp29502_read_vout_ov_limit(struct i2c_client *client, struct mp=
29502_data *data)=0A=
 {=0A=
 	int ret;=0A=
-	int ov_value;=0A=
 =0A=
 	/*=0A=
-	 * This is because the vout ov fault limit value comes from=0A=
-	 * page1 MFR_TSNS_FLT_SET reg, and other telemetry and limit=0A=
-	 * value comes from page0 reg. So the page should be set to=0A=
-	 * 0 after the reading of vout ov limit.=0A=
+	 * The vout ov fault limit value comes from page 1=0A=
+	 * MFR_TSNS_FLT_SET register.=0A=
 	 */=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 1);=0A=
+	ret =3D pmbus_read_word_data(client, 1, 0xff, MFR_TSNS_FLT_SET);=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
-	ret =3D i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
-	ov_value =3D DIV_ROUND_CLOSEST(FIELD_GET(GENMASK(12, 7), ret) *=0A=
-						   MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE,=0A=
-						   data->ovp_div);=0A=
-=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
-	return ov_value;=0A=
+	return DIV_ROUND_CLOSEST(FIELD_GET(GENMASK(12, 7), ret) *=0A=
+				 MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE,=0A=
+				 data->ovp_div);=0A=
 }=0A=
 =0A=
 static int mp29502_write_vout_ov_limit(struct i2c_client *client, u16 word=
,=0A=
@@ -243,46 +230,29 @@ static int mp29502_write_vout_ov_limit(struct i2c_cli=
ent *client, u16 word,=0A=
 	int ret;=0A=
 =0A=
 	/*=0A=
-	 * This is because the vout ov fault limit value comes from=0A=
-	 * page1 MFR_TSNS_FLT_SET reg, and other telemetry and limit=0A=
-	 * value comes from page0 reg. So the page should be set to=0A=
-	 * 0 after the writing of vout ov limit.=0A=
+	 * The vout ov fault limit value is in page 1=0A=
+	 * MFR_TSNS_FLT_SET register.=0A=
 	 */=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 1);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
-	ret =3D i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);=0A=
+	ret =3D pmbus_read_word_data(client, 1, 0xff, MFR_TSNS_FLT_SET);=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
-	ret =3D i2c_smbus_write_word_data(client, MFR_TSNS_FLT_SET,=0A=
-					(ret & ~GENMASK(12, 7)) |=0A=
-		FIELD_PREP(GENMASK(12, 7),=0A=
-			   DIV_ROUND_CLOSEST(word * data->ovp_div,=0A=
-					     MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE)));=0A=
-=0A=
-	return i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
+	return pmbus_write_word_data(client, 1, MFR_TSNS_FLT_SET,=0A=
+				    (ret & ~GENMASK(12, 7)) |=0A=
+				FIELD_PREP(GENMASK(12, 7),=0A=
+					   DIV_ROUND_CLOSEST(word * data->ovp_div,=0A=
+							     MP28502_VOUT_OV_GAIN *=0A=
+							     MP28502_VOUT_OV_SCALE)));=0A=
 }=0A=
 =0A=
 static int mp29502_read_byte_data(struct i2c_client *client, int page, int=
 reg)=0A=
 {=0A=
-	int ret;=0A=
-=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_VOUT_MODE:=0A=
-		ret =3D PB_VOUT_MODE_DIRECT;=0A=
-		break;=0A=
+		return PB_VOUT_MODE_DIRECT;=0A=
 	default:=0A=
-		ret =3D -ENODATA;=0A=
-		break;=0A=
+		return -ENODATA;=0A=
 	}=0A=
-=0A=
-	return ret;=0A=
 }=0A=
 =0A=
 static int mp29502_read_word_data(struct i2c_client *client, int page,=0A=
@@ -470,10 +440,6 @@ static int mp29502_write_word_data(struct i2c_client *=
client, int page, int reg,=0A=
 	struct mp29502_data *data =3D to_mp29502_data(info);=0A=
 	int ret;=0A=
 =0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_VIN_OV_FAULT_LIMIT:=0A=
 		/*=0A=
-- =0A=
2.34.1=0A=
=0A=

